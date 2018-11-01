CREATE TABLE [dbo].[tb_sis_alerta] (
    [CodAlerta]        VARCHAR (50)  NOT NULL,
    [Nombre]           VARCHAR (300) NOT NULL,
    [CodModulo]        VARCHAR (20)  NOT NULL,
    [VistaRpt]         VARCHAR (50)  NOT NULL,
    [Formulario]       VARCHAR (50)  NOT NULL,
    [Class_NomReporte] VARCHAR (50)  NOT NULL,
    [nom_Asembly]      VARCHAR (50)  NOT NULL,
    [Class_Info]       VARCHAR (50)  NOT NULL,
    [Class_Bus]        VARCHAR (50)  NOT NULL,
    [Class_Data]       VARCHAR (50)  NOT NULL,
    [Estado]           BIT           NOT NULL,
    [observacion]      VARCHAR (500) NULL,
    CONSTRAINT [PK_tb_sis_alerta] PRIMARY KEY CLUSTERED ([CodAlerta] ASC),
    CONSTRAINT [FK_tb_sis_alerta_tb_modulo] FOREIGN KEY ([CodModulo]) REFERENCES [dbo].[tb_modulo] ([CodModulo])
);

