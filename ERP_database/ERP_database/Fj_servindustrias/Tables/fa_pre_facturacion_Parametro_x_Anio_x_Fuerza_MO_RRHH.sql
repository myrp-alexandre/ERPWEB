CREATE TABLE [Fj_servindustrias].[fa_pre_facturacion_Parametro_x_Anio_x_Fuerza_MO_RRHH] (
    [IdEmpresa]             INT              NOT NULL,
    [Anio]                  INT              NOT NULL,
    [Mes]                   INT              NOT NULL,
    [IdFuerza]              INT              NOT NULL,
    [Porcentaje_Calculo_BS] NUMERIC (18, 10) NOT NULL,
    [Porcentaje_Calculo_MO] NUMERIC (18, 10) NOT NULL,
    [Observacion]           VARCHAR (100)    NULL,
    CONSTRAINT [PK_fa_pre_facturacion_Parametro_x_Anio_x_Fuerza_MO_RRHH] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [Anio] ASC, [Mes] ASC, [IdFuerza] ASC)
);

