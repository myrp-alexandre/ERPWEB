CREATE TABLE [dbo].[ro_Parametros] (
    [IdEmpresa]                      INT          NOT NULL,
    [IdTipoCbte_AsientoSueldoXPagar] INT          NOT NULL,
    [Sueldo_basico]                  FLOAT (53)   NOT NULL,
    [Porcentaje_aporte_pers]         FLOAT (53)   NOT NULL,
    [Porcentaje_aporte_patr]         FLOAT (53)   NOT NULL,
    [IdRubro_acta_finiquito]         VARCHAR (50) NOT NULL,
    [genera_op_x_pago]               BIT          NOT NULL,
    [Genera_op_x_pago_x_empleao]     BIT          NOT NULL,
    [Genera_op_por_liq_vacaciones]   BIT          NOT NULL,
    [Genera_op_por_acta_finiquito]   BIT          NOT NULL,
    [Genera_op_por_prestamos]        BIT          NOT NULL,
    [IdTipo_op_vacaciones]           VARCHAR (20) NOT NULL,
    [IdTipo_op_prestamos]            VARCHAR (20) NOT NULL,
    [IdTipo_op_acta_finiquito]       VARCHAR (20) NOT NULL,
    [IdTipo_op_sueldo_por_pagar]     VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_ro_Parametros] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC),
    CONSTRAINT [FK_ro_Parametros_tb_empresa] FOREIGN KEY ([IdEmpresa]) REFERENCES [dbo].[tb_empresa] ([IdEmpresa])
);



