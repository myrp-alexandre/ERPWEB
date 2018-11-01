CREATE TABLE [dbo].[tb_sis_Mensajes_sys] (
    [IdSecuencia]     NUMERIC (18)  NOT NULL,
    [IdMensaje]       VARCHAR (80)  NOT NULL,
    [Mensaje_Esp]     VARCHAR (500) NOT NULL,
    [Mensaje_Englesh] VARCHAR (500) NOT NULL,
    [Estado]          CHAR (1)      NOT NULL,
    CONSTRAINT [PK_tb_sis_Mensajes_sys] PRIMARY KEY CLUSTERED ([IdMensaje] ASC)
);

