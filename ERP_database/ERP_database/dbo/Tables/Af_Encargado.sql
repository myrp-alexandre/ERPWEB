CREATE TABLE [dbo].[Af_Encargado] (
    [IdEmpresa]     INT           NOT NULL,
    [IdEncargado]   DECIMAL (18)  NOT NULL,
    [estado]        CHAR (1)      NOT NULL,
    [nom_encargado] VARCHAR (100) NULL,
    CONSTRAINT [PK_Af_Encargado] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdEncargado] ASC)
);

