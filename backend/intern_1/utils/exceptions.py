from rest_framework.views import exception_handler
from rest_framework.response import Response
from rest_framework import status

class DBError(Exception):
    pass

class NotFound(Exception):
    pass



def errors_handle(exc, context):

    response = exception_handler(exc, context)

    if response is None:
        if isinstance(exc, DBError):
            return Response({"success": False, "message": str(exc)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        if isinstance(exc, NotFound):
            return Response({"success": False, "message": str(exc)}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response({"success": False, "message": str(exc)}, status=status.HTTP_400_BAD_REQUEST)

    return
