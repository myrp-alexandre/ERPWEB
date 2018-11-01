CREATE TABLE [dbo].[tb_banco_procesos_bancarios_tipo] (
    [IdProceso_bancario_tipo] VARCHAR (25)  NOT NULL,
    [Iniciales_Archivo]       VARCHAR (50)  NOT NULL,
    [nom_proceso_bancario]    VARCHAR (150) NOT NULL,
    [Tipo_Proc]               VARCHAR (10)  NULL,
    CONSTRAINT [PK_tb_banco_procesos_bancarios_tipo_1] PRIMARY KEY CLUSTERED ([IdProceso_bancario_tipo] ASC)
);

