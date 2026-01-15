using Dapper;
using System.Data;

namespace SqlInterface
{
    public interface ISqlProvider
    {
        Task<IEnumerable<TReturnedDataModel>> QueryData<TReturnedDataModel>(string sql);
        Task<IEnumerable<TReturnedDataModel>> ExecuteStoredProcedure<TReturnedDataModel>(string storedProcedure, object? parameters = null);
        Task QueryMultipleDataSets(string sql, Action<SqlMapper.GridReader> callback);
        Task ExecuteStoredProcedureMultiple(string storedProcedure, Action<SqlMapper.GridReader> callback, object? parameters = null);
    }
}