using Challenge.Repositories;
using Challenge.Services;
using SqlInterface;

namespace Challenge.API.Extensions;

public static class ServiceCollectionExtensions
{
    private static int dbTimeout = 500;

    public static IServiceCollection AddDependencies(this IServiceCollection services, IConfiguration config)
    {
        InjectRepositories(services, config);

        services.AddScoped<IDriverActivityService, DriverActivityService>();

        return services;
    }

    private static void InjectRepositories(IServiceCollection services, IConfiguration config)
    {
        services.AddMemoryCache();

        services.AddScoped<ISqlProvider>(s => new SqlProvider(config.GetConnectionString("SqlConnection"), dbTimeout));
        
        services.AddScoped<IDriverActivityRepository, DriverActivityRepository>();
    }
}
