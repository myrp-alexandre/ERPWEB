CREATE TABLE [dbo].[ro_tipo_gastos_personales] (
    [IdTipoGasto]    VARCHAR (10) NOT NULL,
    [nom_tipo_gasto] VARCHAR (50) NOT NULL,
    [estado]         CHAR (1)     NOT NULL,
    [orden]          INT          NOT NULL,
    CONSTRAINT [PK_ro_tipo_gastos_personales] PRIMARY KEY CLUSTERED ([IdTipoGasto] ASC)
);

