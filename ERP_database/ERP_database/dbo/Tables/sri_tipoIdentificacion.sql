CREATE TABLE [dbo].[sri_tipoIdentificacion] (
    [IdTipoIdenti] VARCHAR (5)  NOT NULL,
    [descripcion]  VARCHAR (50) NULL,
    [Estado]       NCHAR (10)   NULL,
    [IdCodigo2]    VARCHAR (5)  NULL,
    CONSTRAINT [PK_sri_tipoIdentificacion] PRIMARY KEY CLUSTERED ([IdTipoIdenti] ASC)
);

