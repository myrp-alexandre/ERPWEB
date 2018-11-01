CREATE TABLE [dbo].[cp_estado] (
    [IdEstado_cp]      VARCHAR (25) NOT NULL,
    [nom_estado_cp]    VARCHAR (50) NOT NULL,
    [IdEstado_cp_tipo] VARCHAR (25) NOT NULL,
    CONSTRAINT [PK_cp_estado] PRIMARY KEY CLUSTERED ([IdEstado_cp] ASC)
);

