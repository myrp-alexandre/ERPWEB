CREATE TABLE [Fj_servindustrias].[fa_compensacion_x_ct_centro_costo] (
    [IdEmpresa]                         INT           NOT NULL,
    [IdCompensacion]                    INT           NOT NULL,
    [IdCentroCosto]                     VARCHAR (20)  NOT NULL,
    [IdCentroCosto_sub_centro_costo]    VARCHAR (20)  NULL,
    [observacion]                       VARCHAR (500) NULL,
    [valor_a_financiar]                 FLOAT (53)    NOT NULL,
    [num_cuotas_meses_x_centro_costo]   FLOAT (53)    NOT NULL,
    [num_cuotas_meses_x_banco]          FLOAT (53)    NOT NULL,
    [tasa_interes_anual_x_centro_costo] FLOAT (53)    NOT NULL,
    [tasa_interes_anual_x_banco]        FLOAT (53)    NOT NULL,
    [estado]                            BIT           NOT NULL,
    CONSTRAINT [PK_fa_compensacion_x_ct_centro_costo] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCompensacion] ASC),
    CONSTRAINT [FK_fa_compensacion_x_ct_centro_costo_ct_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto]) REFERENCES [dbo].[ct_centro_costo] ([IdEmpresa], [IdCentroCosto]),
    CONSTRAINT [FK_fa_compensacion_x_ct_centro_costo_ct_centro_costo_sub_centro_costo] FOREIGN KEY ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]) REFERENCES [dbo].[ct_centro_costo_sub_centro_costo] ([IdEmpresa], [IdCentroCosto], [IdCentroCosto_sub_centro_costo]),
    CONSTRAINT [FK_fa_compensacion_x_ct_centro_costo_tb_empresa] FOREIGN KEY ([IdEmpresa]) REFERENCES [dbo].[tb_empresa] ([IdEmpresa])
);

