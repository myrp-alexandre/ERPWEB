CREATE TABLE [dbo].[cp_conciliacion_Caja_det] (
    [IdEmpresa]                      INT          NOT NULL,
    [IdConciliacion_Caja]            NUMERIC (18) NOT NULL,
    [Secuencia]                      INT          NOT NULL,
    [IdEmpresa_OGiro]                INT          NOT NULL,
    [IdCbteCble_Ogiro]               NUMERIC (18) NOT NULL,
    [IdTipoCbte_Ogiro]               INT          NOT NULL,
    [IdTipoMovi]                     INT          NULL,
    [IdUsuario]                      VARCHAR (20) NULL,
    [Fecha_Transac]                  DATETIME     NULL,
    [nom_pc]                         VARCHAR (50) NULL,
    [ip]                             VARCHAR (25) NULL,
    [IdCentroCosto]                  VARCHAR (20) NULL,
    [IdCentroCosto_sub_centro_costo] VARCHAR (20) NULL,
    [Valor_a_aplicar]                MONEY        NOT NULL,
    [Tipo_documento]                 VARCHAR (10) NULL,
    [IdEmpresa_OP]                   INT          NULL,
    [IdOrdenPago_OP]                 NUMERIC (18) NULL,
    CONSTRAINT [PK_cp_Conciliacion_Caja_1] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdConciliacion_Caja] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_cp_conciliacion_Caja_det_cp_conciliacion_Caja] FOREIGN KEY ([IdEmpresa], [IdConciliacion_Caja]) REFERENCES [dbo].[cp_conciliacion_Caja] ([IdEmpresa], [IdConciliacion_Caja]),
    CONSTRAINT [FK_cp_conciliacion_Caja_det_ct_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto]) REFERENCES [dbo].[ct_centro_costo] ([IdEmpresa], [IdCentroCosto]),
    CONSTRAINT [FK_cp_conciliacion_Caja_det_ct_centro_costo_sub_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]) REFERENCES [dbo].[ct_centro_costo_sub_centro_costo] ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo])
);

