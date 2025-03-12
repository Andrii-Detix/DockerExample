FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

WORKDIR /app/src

COPY DockerExample.csproj .
RUN dotnet restore "./DockerExample.csproj"

COPY Program.cs .
RUN dotnet publish -c DockerExample -o publish

FROM mcr.microsoft.com/dotnet/runtime:9.0 AS final

WORKDIR /app
COPY --from=build /app/src/publish .
ENTRYPOINT ["dotnet", "DockerExample.dll"]