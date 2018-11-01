CREATE TABLE [dbo].[Af_Departamento] (
    [IdEmpresa]        INT           NOT NULL,
    [IdDepartamento]   INT           NOT NULL,
    [estado]           CHAR (1)      NOT NULL,
    [nom_departamento] VARCHAR (100) NULL,
    CONSTRAINT [PK_Af_Departamento] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdDepartamento] ASC)
);

