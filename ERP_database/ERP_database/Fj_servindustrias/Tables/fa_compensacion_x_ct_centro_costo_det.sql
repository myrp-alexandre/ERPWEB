CREATE TABLE [Fj_servindustrias].[fa_compensacion_x_ct_centro_costo_det] (
    [IdEmpresa]                  INT        NOT NULL,
    [IdCompensacion]             INT        NOT NULL,
    [Secuencia]                  INT        NOT NULL,
    [num_mes]                    INT        NOT NULL,
    [capital_reducido]           FLOAT (53) NOT NULL,
    [valor_amortizacion]         FLOAT (53) NULL,
    [valor_interes_banco]        FLOAT (53) NULL,
    [valor_interes_centro_costo] FLOAT (53) NULL,
    [valor_interes_diferencia]   FLOAT (53) NULL,
    [dividendo]                  FLOAT (53) NULL,
    [IdPeriodo]                  INT        NULL,
    [estado_cobro]               BIT        NOT NULL,
    CONSTRAINT [PK_fa_compensacion_x_ct_centro_costo_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdCompensacion] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_fa_compensacion_x_ct_centro_costo_det_ct_periodo] FOREIGN KEY ([IdEmpresa], [IdPeriodo]) REFERENCES [dbo].[ct_periodo] ([IdEmpresa], [IdPeriodo])
);

