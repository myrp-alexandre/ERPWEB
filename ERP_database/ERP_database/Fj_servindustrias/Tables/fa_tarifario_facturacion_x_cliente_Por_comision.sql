CREATE TABLE [Fj_servindustrias].[fa_tarifario_facturacion_x_cliente_Por_comision] (
    [IdEmpresa]    INT          NOT NULL,
    [IdTarifario]  NUMERIC (18) NOT NULL,
    [IdAnio]       INT          NOT NULL,
    [Fecha_inicio] DATE         NOT NULL,
    [Fecha_Fin]    DATE         NOT NULL,
    [porcentaje]   FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_fa_tarifario_facturacion_x_cliente_Por_comision] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdTarifario] ASC, [IdAnio] ASC),
    CONSTRAINT [FK_fa_tarifario_facturacion_x_cliente_Por_comision_fa_tarifario_facturacion_x_cliente] FOREIGN KEY ([IdEmpresa], [IdTarifario]) REFERENCES [Fj_servindustrias].[fa_tarifario_facturacion_x_cliente] ([IdEmpresa], [IdTarifario])
);

