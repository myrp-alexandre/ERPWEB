CREATE TABLE [dbo].[sri_provincia] (
    [IdProvincia]    VARCHAR (20) NOT NULL,
    [descripcion]    VARCHAR (50) NULL,
    [estado]         CHAR (1)     NULL,
    [Cod_Telefonico] VARCHAR (5)  NULL,
    CONSTRAINT [PK_sri_provincia] PRIMARY KEY CLUSTERED ([IdProvincia] ASC)
);

