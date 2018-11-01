CREATE TABLE [dbo].[sri_tipo_Gasto] (
    [IdTipoGasto] VARCHAR (50)  NOT NULL,
    [Descripcion] VARCHAR (150) NULL,
    [Estado]      CHAR (1)      NULL,
    CONSTRAINT [PK_sri_tipo_Gasto] PRIMARY KEY CLUSTERED ([IdTipoGasto] ASC)
);

