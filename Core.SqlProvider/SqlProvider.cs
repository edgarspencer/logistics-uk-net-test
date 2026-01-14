using Dapper;
using System.Data;
using Microsoft.Data.SqlClient;

namespace SqlInterface;

public class SqlProvider : ISqlProvider
{
    private readonly string _connectionString;
    private readonly int _commandTimeout;

    public SqlProvider(string connectionString, int commandTimeout)
    {
        _connectionString = connectionString;
        _commandTimeout = commandTimeout;
        DefaultTypeMap.MatchNamesWithUnderscores = true;
    }

    public async Task<IEnumerable<TReturnedDataModel>> QueryData<TReturnedDataModel>(string storedProcedure)
    {
        using var connection = new SqlConnection(_connectionString);
        return await connection.QueryAsync<TReturnedDataModel>(storedProcedure, new { }, commandType: CommandType.StoredProcedure, commandTimeout: _commandTimeout);
    }

    public async Task QueryMultipleDataSets(
        string storedProcedure,
        Action<SqlMapper.GridReader> callback)
    {
        using var connection = new SqlConnection(_connectionString);
        var results = await connection.QueryMultipleAsync(
            sql: storedProcedure,
            param: new { },
            commandTimeout: _commandTimeout,
            commandType: CommandType.StoredProcedure);

        callback(results);
    }
}
