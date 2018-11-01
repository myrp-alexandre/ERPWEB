CREATE TABLE [dbo].[tb_sis_log_error] (
    [IdEmpresa]        INT           NOT NULL,
    [IdError]          NUMERIC (18)  NOT NULL,
    [DescripcionError] VARCHAR (MAX) NOT NULL,
    [Modulo]           VARCHAR (50)  NOT NULL,
    [Accion]           VARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_tb_sis_log_error] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdError] ASC)
);

