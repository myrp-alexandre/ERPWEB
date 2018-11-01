CREATE TABLE [Fj_servindustrias].[fa_tarifario_horometro] (
    [IdEmpresa]               INT            NOT NULL,
    [IdTarifario]             INT            NOT NULL,
    [IdCentroCosto]           VARCHAR (20)   NOT NULL,
    [Observacion]             VARCHAR (5000) NULL,
    [estado]                  BIT            NOT NULL,
    [IdProducto_hora_regular] NUMERIC (18)   NOT NULL,
    [IdProducto_hora_extra]   NUMERIC (18)   NOT NULL,
    [IdPeriodo_ini]           INT            NOT NULL,
    [IdPeriodo_fin]           INT            NOT NULL,
    [IdCod_Impuesto]          VARCHAR (25)   NOT NULL,
    [porcentaje]              FLOAT (53)     NOT NULL,
    CONSTRAINT [PK_fa_tarifario_horometro] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTarifario] ASC),
    CONSTRAINT [FK_fa_tarifario_horometro_ct_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto]) REFERENCES [dbo].[ct_centro_costo] ([IdEmpresa], [IdCentroCosto]),
    CONSTRAINT [FK_fa_tarifario_horometro_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto_hora_regular]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto]),
    CONSTRAINT [FK_fa_tarifario_horometro_in_Producto1] FOREIGN KEY ([IdEmpresa], [IdProducto_hora_extra]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto]),
    CONSTRAINT [FK_fa_tarifario_horometro_tb_sis_Impuesto] FOREIGN KEY ([IdCod_Impuesto]) REFERENCES [dbo].[tb_sis_Impuesto] ([IdCod_Impuesto])
);

