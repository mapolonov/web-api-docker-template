FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY src/mikeApiService/mikeApiService.csproj myMicroservice/
RUN dotnet restore myMicroservice/mikeApiService.csproj
WORKDIR /src/myMicroservice
COPY . .
RUN dotnet build mikeApiService.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish mikeApiService.csproj -c Release -o /app

FROM base AS final
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "mikeApiService.dll"]