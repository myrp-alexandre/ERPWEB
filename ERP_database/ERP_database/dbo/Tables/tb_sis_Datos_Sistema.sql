CREATE TABLE [dbo].[tb_sis_Datos_Sistema] (
    [Id]              INT           NOT NULL,
    [Nombre_sistema]  VARCHAR (50)  NOT NULL,
    [version]         VARCHAR (12)  NOT NULL,
    [Propietario]     VARCHAR (50)  NOT NULL,
    [Desarrolladores] VARCHAR (500) NOT NULL,
    [Observacion]     VARCHAR (500) NOT NULL,
    CONSTRAINT [PK_tb_sis_Datos_Sistema] PRIMARY KEY CLUSTERED ([Id] ASC)
);

