using Dapper;

namespace SqlInterface
{
    public interface ISqlProvider
    {
        Task<IEnumerable<TReturnedDataModel>> QueryData<TReturnedDataModel>(string storedProcedure);
        Task QueryMultipleDataSets(string storedProcedure, Action<SqlMapper.GridReader> callback);
    }
}