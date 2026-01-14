import { useCallback, useEffect, useState } from "react";

type Callback<P, R> = (props: P) => Promise<R>;

type UseApiProps<P, R> = {
    callback: Callback<P, R>;
    fetchOnMount?: boolean;
    initialProps?: P;
}

export function useApi<R, P = any>({ callback, fetchOnMount = false, initialProps }: UseApiProps<P, R>): {
    isLoading: boolean;
    isRefetching: boolean;
    data: R | null;
    error: Error | null;
    fetch: (props?: P) => Promise<void>;
    refetch: (props?: P) => Promise<void>;
    mutate: (props?: P) => Promise<R>;
} {
    const [isLoading, setIsLoading] = useState(false);
    const [isRefetching, setIsRefetching] = useState(false);
    const [data, setData] = useState<R | null>(null);
    const [error, setError] = useState<Error | null>(null);

    const fetch = useCallback(async (props?: P) => {
        try {
            setIsLoading(true);

            const result = await callback(props as P);
            setData(result);
            setError(null);

        } catch (error) {
            setError(error as Error);
        } finally {
            setIsLoading(false);
        }
    }, [callback]);

    const refetch = useCallback(async (props?: P) => {
        try {
            setIsRefetching(true);
            await fetch(props);

        } finally {
            setIsRefetching(false);
        }
    }, [fetch]);

    const mutate = useCallback(async (props?: P): Promise<R> => {
        try {
            setIsLoading(true);
            const result = await callback(props as P);
            setData(result);
            setError(null);
            return result;
        } catch (error) {
            setError(error as Error);
            throw error;
        } finally {
            setIsLoading(false);
        }
    }, [callback]);

    useEffect(() => {

        if (!fetchOnMount) {
            return () => { };
        }

        let isMounted = true;

        const fetchData = async () => {
            if (isMounted) {
                await fetch(initialProps);
            }
        };

        fetchData();

        return () => {
            isMounted = false;
        };
    }, [fetch, fetchOnMount]);

    return {
        isLoading,
        isRefetching,
        data,
        error,
        fetch,
        refetch,
        mutate,
    };
}