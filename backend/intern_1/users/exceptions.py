from rest_framework.views import exception_handler
from rest_framework.response import Response
from rest_framework import status


class ValidationError(Exception):
    pass

class EmailConflictError(Exception):
    pass

class InvalidCredentials(Exception):
    pass

class InvalidToken(Exception):
    pass


def errors_handle(exc, context):

    response = exception_handler(exc, context)

    if response is None:
        if isinstance(exc, ValidationError):
            return Response({"success": False, "message": str(exc)}, status=status.HTTP_400_BAD_REQUEST)
        if isinstance(exc, EmailConflictError):
            return Response({"success": False, "message": str(exc)}, status=status.HTTP_409_CONFLICT)
        if isinstance(exc, InvalidCredentials):
            return Response({"success": False, "message": str(exc)}, status=status.HTTP_401_UNAUTHORIZED)
        if isinstance(exc, InvalidToken):
            return Response({"success": False, "message": str(exc)}, status=status.HTTP_401_UNAUTHORIZED)
        else:
            return Response({"success": False, "message": str(exc)}, status=status.HTTP_400_BAD_REQUEST)

    return
