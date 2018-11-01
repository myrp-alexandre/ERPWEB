CREATE TABLE [dbo].[tb_sis_Actualizaciones_x_tablas] (
    [IdTabla]          VARCHAR (150) NOT NULL,
    [ult_fecha_update] DATETIME      NULL,
    [ult_proceso]      VARCHAR (MAX) NULL,
    CONSTRAINT [PK_tb_sis_Actualizaciones_x_tablas] PRIMARY KEY CLUSTERED ([IdTabla] ASC)
);

