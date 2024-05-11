from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from rest_framework.response import Response
import logging
from django.contrib.auth import authenticate, login, logout
from rest_framework.decorators import api_view
from mayekawa.serializers import LoginSerializer


class Login(generics.GenericAPIView):
    serializer_class = LoginSerializer

    def post(self, request):
        try:
            username = request.data.get('username')
            password = request.data.get('password')

            if username and password:
                user = authenticate(username=username, password=password)
                if user:
                    resp = login(request, user)
                    print(resp)
                    return Response({"status":200, "message":"User successfully logged in", 'data': user.email},
                        status=status.HTTP_200_OK)
            raise Exception('No such user')
        except Exception as e:
            logging.info(f"User authentication failed due to exception {e}")
            return Response({"status":401, "message": "invalid_credentials"},
                          status=status.HTTP_200_OK)


@api_view(['POST'])
def logout_view(request):
    logout(request)
    return Response({"status":200, "message": "You have been logged out"},
                          status=status.HTTP_200_OK)
