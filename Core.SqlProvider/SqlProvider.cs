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

    public async Task<IEnumerable<TReturnedDataModel>> QueryData<TReturnedDataModel>(string sql)
    {
        using var connection = new SqlConnection(_connectionString);
        return await connection.QueryAsync<TReturnedDataModel>(sql, commandTimeout: _commandTimeout);
    }

    public async Task<IEnumerable<TReturnedDataModel>> ExecuteStoredProcedure<TReturnedDataModel>(
        string storedProcedure,
        object? parameters = null)
    {
        using var connection = new SqlConnection(_connectionString);
        return await connection.QueryAsync<TReturnedDataModel>(
            storedProcedure,
            parameters,
            commandType: CommandType.StoredProcedure,
            commandTimeout: _commandTimeout);
    }

    public async Task QueryMultipleDataSets(
        string sql,
        Action<SqlMapper.GridReader> callback)
    {
        using var connection = new SqlConnection(_connectionString);
        var results = await connection.QueryMultipleAsync(
            sql: sql,
            commandTimeout: _commandTimeout);

        callback(results);
    }

    public async Task ExecuteStoredProcedureMultiple(
        string storedProcedure,
        Action<SqlMapper.GridReader> callback,
        object? parameters = null)
    {
        using var connection = new SqlConnection(_connectionString);
        var results = await connection.QueryMultipleAsync(
            sql: storedProcedure,
            param: parameters,
            commandType: CommandType.StoredProcedure,
            commandTimeout: _commandTimeout);

        callback(results);
    }
}
