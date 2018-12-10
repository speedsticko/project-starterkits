
https://github.com/dotnet/dotnet-docker/blob/master/samples/aspnetapp/aspnet-docker-dev-in-container.md

1. Run the "dotnet new" command in the container to create the new web app in the mapped volume
docker run --rm -it -v ${pwd}:/app/ -w /app/dotnetapp microsoft/dotnet:2.2-sdk dotnet new web --auth Individual

2. Run the "dotnet run" command in hte container to see the changes
docker run --rm -it -v ${pwd}:/app/ -p 5000:5000 -w /app/dotnetapp microsoft/dotnet:2.2-sdk dotnet watch run --urls http://0.0.0.0:5000

