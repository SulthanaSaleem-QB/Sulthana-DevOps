from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import SessionAuthentication, BasicAuthentication
from rest_framework import status
from rest_framework.response import Response
from mayekawa.choices import Product_Codes


class ProductCodes(generics.ListCreateAPIView):
    permission_classes = (IsAuthenticated,)
    
    def list(self, request):
        data = Product_Codes
        return Response(
            {"message": "successfully listed product codes", "data": data},
            status=status.HTTP_200_OK
        )
