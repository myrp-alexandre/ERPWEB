CREATE TABLE [dbo].[sri_ciudad] (
    [IdCiudad]    VARCHAR (20)  NOT NULL,
    [IdPais]      VARCHAR (20)  NOT NULL,
    [Descripcion] VARCHAR (150) NOT NULL,
    [estado]      NCHAR (10)    NOT NULL,
    CONSTRAINT [PK_sri_ciudad] PRIMARY KEY CLUSTERED ([IdCiudad] ASC, [IdPais] ASC)
);

