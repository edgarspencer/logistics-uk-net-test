# Logistics UK - Driver Activity Challenge

A full-stack application for tracking and visualizing driver activities, shifts, and compliance status.

## Tech Stack

### Backend
- **.NET 10** (C#)
- **ASP.NET Core Web API**
- **Dapper** (micro-ORM)
- **SQL Server** (via Microsoft.Data.SqlClient)

### Frontend
- **React 19** with TypeScript
- **Vite 7** (build tool)
- **React Router 7**
- **Axios** (HTTP client)

## Project Structure

```
logisticsuk/
├── Challenge.API/           # ASP.NET Core Web API
├── Challenge.Database/      # Database setup scripts
│   ├── Initial_Setup.sql    # Complete database setup (tables, procedures, seed data)
│   ├── Tables/              # Individual table definitions
│   └── StoredProcedures/    # Stored procedure definitions
├── Challenge.Models/        # Shared data models
├── Challenge.Repositories/  # Data access layer
├── Challenge.Services/      # Business logic layer
├── Core.SqlProvider/        # Database connection provider
└── Challenge.UI/            # React frontend
```

## Prerequisites

- [.NET 10 SDK](https://dotnet.microsoft.com/download)
- [Node.js 18+](https://nodejs.org/) (for frontend)
- [SQL Server](https://www.microsoft.com/sql-server) or [SQL Server Docker image](https://hub.docker.com/_/microsoft-mssql-server)

## Setup Instructions

### 1. Database Setup

#### Start SQL Server (Docker)

```bash
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=YourStrong!Passw0rd" \
  -p 1433:1433 --name sqlserver \
  -d mcr.microsoft.com/mssql/server:2022-latest
```

Default credentials:
- **Host:** 127.0.0.1
- **Port:** 1433
- **User:** sa
- **Password:** YourStrong!Passw0rd

#### Create Database and Run Initial Setup

1. Connect to SQL Server and create the database:
   ```sql
   CREATE DATABASE logisticsuk;
   ```

2. Run the initial setup script to create tables, stored procedures, and seed data:
   ```bash
   # Using sqlcmd
   sqlcmd -S 127.0.0.1,1433 -U sa -P "YourStrong!Passw0rd" -d logisticsuk -i Challenge.Database/Initial_Setup.sql
   ```

   Or using Azure Data Studio / SQL Server Management Studio:
   - Connect to `127.0.0.1,1433` with user `sa`
   - Open `Challenge.Database/Initial_Setup.sql`
   - Execute the script against the `logisticsuk` database

The `Initial_Setup.sql` script will:
- Create the `Driver` table
- Create the `Driver_Trace` table
- Create the `stp_Get_Driver_Activity` stored procedure
- Insert seed data for 10 drivers with activity records

### 2. Backend Setup

```bash
cd Challenge.API
dotnet restore
dotnet run
```

The API will start at `http://localhost:5000` (or as configured).

### 3. Frontend Setup

```bash
cd Challenge.UI
npm install
npm run dev
```

The frontend will start at `http://localhost:5173`.

## Available Commands

### Backend

| Command | Description |
|---------|-------------|
| `dotnet restore` | Restore NuGet packages |
| `dotnet build` | Build the solution |
| `dotnet run` | Run the API |
| `dotnet watch run` | Run with hot reload |

### Frontend

| Command | Description |
|---------|-------------|
| `npm install` | Install dependencies |
| `npm run dev` | Start development server |
| `npm run build` | Build for production |
| `npm run preview` | Preview production build |
| `npm run lint` | Run ESLint |

## Database Schema

### Tables

#### Driver
| Column | Type | Description |
|--------|------|-------------|
| Driver_ID | INT | Primary key |
| Surname | NVARCHAR(50) | Driver's surname |
| Forename | NVARCHAR(50) | Driver's forename |

#### Driver_Trace
| Column | Type | Description |
|--------|------|-------------|
| Driver_Trace_ID | INT IDENTITY | Primary key (auto-increment) |
| Driver_ID | INT | Foreign key to Driver |
| Vehicle_Registration | NVARCHAR(15) | Vehicle registration number |
| Activity_Start_Date | DATETIME2 | Activity start timestamp |
| Activity_End_Date | DATETIME2 | Activity end timestamp |
| Activity_Type | NVARCHAR(10) | Type: drive, rest, work, available |

### Stored Procedures

#### stp_Get_Driver_Activity
Returns all driver activities joined with driver information. Used by the API to fetch driver activity data.

```sql
EXEC stp_Get_Driver_Activity
```

## Configuration

### API Configuration (`Challenge.API/appsettings.json`)

```json
{
  "ConnectionStrings": {
    "SqlConnection": "Server=127.0.0.1,1433;Database=logisticsuk;User Id=sa;Password=YourStrong!Passw0rd;TrustServerCertificate=True;"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  }
}
```

### Connection String Format

SQL Server connection strings use the format:
```
Server=<host>,<port>;Database=<database>;User Id=<user>;Password=<password>;TrustServerCertificate=True;
```

For Windows Authentication:
```
Server=<host>,<port>;Database=<database>;Trusted_Connection=True;TrustServerCertificate=True;
```

### Frontend Configuration

The API base URL is configured in `Challenge.UI/src/api/ApiService.ts`. Update if your backend runs on a different port.

## API Endpoints

### Drivers

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/drivers/activities` | Get driver activities with day statuses |

Query parameters:
- `startDate` (required): Start date (YYYY-MM-DD)
- `endDate` (required): End date (YYYY-MM-DD)
- `search` (optional): Search by driver name or vehicle registration

Example:
```
GET /api/drivers/activities?startDate=2021-02-01&endDate=2021-02-07&search=smith
```

## Troubleshooting

### Database Connection Issues

1. Verify SQL Server is running:
   ```bash
   docker ps | grep sqlserver
   ```

2. Test connection with sqlcmd:
   ```bash
   sqlcmd -S 127.0.0.1,1433 -U sa -P "YourStrong!Passw0rd" -Q "SELECT 1"
   ```

3. Check the connection string format (SQL Server uses comma for port, not colon)

4. Ensure `TrustServerCertificate=True` is set for local development

### Verify Database Setup

```bash
sqlcmd -S 127.0.0.1,1433 -U sa -P "YourStrong!Passw0rd" -d logisticsuk -Q "SELECT COUNT(*) FROM Driver; SELECT COUNT(*) FROM Driver_Trace;"
```

Expected output: 10 drivers, 300+ driver trace records.

### Test Stored Procedure

```bash
sqlcmd -S 127.0.0.1,1433 -U sa -P "YourStrong!Passw0rd" -d logisticsuk -Q "EXEC stp_Get_Driver_Activity"
```

### Frontend Build Errors

1. Delete `node_modules` and `package-lock.json`
2. Run `npm install` again
3. Clear Vite cache: `rm -rf node_modules/.vite`

### Common SQL Server Docker Issues

1. **Container won't start:** Ensure password meets complexity requirements (uppercase, lowercase, number, special char, min 8 chars)

2. **Connection refused:** Wait a few seconds after starting the container for SQL Server to initialize

3. **Port conflict:** Check if port 1433 is already in use:
   ```bash
   lsof -i :1433
   ```

## License

This project is for demonstration purposes.
