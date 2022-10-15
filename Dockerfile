# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY src/*.sln .
COPY src/BeYourMarket.Web/*.csproj ./
RUN dotnet restore "BeYourMarket.Web.csproj"

# copy everything else and build app
COPY . .

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /source
COPY --from=build /source ./
EXPOSE 443
ENTRYPOINT ["dotnet", "BeYourMarket.Web.dll"]
