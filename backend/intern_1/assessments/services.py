import re

from utils.exceptions import NotFound
from .models import *

class AssessmentService:
    @staticmethod
    def get_assessment(pk):
        if Assessment.objects.filter(pk=pk).exists():
            assessment = Assessment.objects.get(pk=pk)
            questions = (
                Question.objects
                .filter(AssessmentFk=assessment.AssessmentID)
                .prefetch_related('option_set')
            )
            json = {
                "AssessmentID": assessment.AssessmentID,
                "Title": assessment.Title,
                "Duration": str(assessment.Duration),
                "Subject": assessment.Subject,
                "Grade": assessment.Grade,
                "Questions": []
            }
            for q in questions:
                json["Questions"].append({
                    "QuestionID": q.QuestionID,
                    "Question": q.Question,
                    "Options": [
                        {
                            "OptionID": opt.OptionID,
                            "Option": opt.Option,

                        }
                        for opt in q.option_set.all()
                    ]
                })
            return json
        else:
            raise NotFound("Assessment Not Found")

    @staticmethod
    def check_assessment(data):
        assessment = Assessment.objects.get(pk=data["AssessmentID"])
        answers_map = {
            ans["questionId"]: ans["chosenOptionId"]
            for ans in data["answers"]
        }
        questions = (
            Question.objects
            .filter(AssessmentFk=assessment.AssessmentID)
            .prefetch_related('option_set')
        )
        print("questions")
        print(questions)
        json = {
            "AssessmentID": assessment.AssessmentID,
            "Title": assessment.Title,
            "Duration": str(assessment.Duration),
            "Subject": assessment.Subject,
            "Grade": assessment.Grade,
            "Score": 0,
            "Total Score":0,
            "Questions": [],
        }
        print("json")
        print(json)
        for q in questions:
            json["Total Score"] += 1
            q_options = []
            chosen_option_id = answers_map.get(q.QuestionID)
            json["Questions"].append({
                "QuestionID": q.QuestionID,
                "Question": q.Question,
                "Options": q_options
            })
            for opt in q.option_set.all():
                q_options.append(
                        {
                            "OptionID": opt.OptionID,
                            "Option": opt.Option,
                            "isChosen": opt.OptionID == chosen_option_id,
                            "isCorrect": opt.isCorrect
                        }
                    )
                if opt.OptionID == chosen_option_id and opt.isCorrect:
                    json["Score"] += 1
        print("json after")
        print(json)

        return json
