CREATE TABLE [dbo].[fa_factura_x_fa_TerminoPago] (
    [IdEmpresa]        INT          NOT NULL,
    [IdSucursal]       INT          NOT NULL,
    [IdBodega]         INT          NOT NULL,
    [IdCbteVta]        NUMERIC (18) NOT NULL,
    [IdTerminoPago]    VARCHAR (20) NOT NULL,
    [Secuencia]        INT          NOT NULL,
    [Fecha]            DATETIME     NOT NULL,
    [Fecha_vct]        DATETIME     NOT NULL,
    [Dias_Plazo]       INT          NOT NULL,
    [Por_Distribucion] FLOAT (53)   NOT NULL,
    [Valor]            FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_fa_factura_x_fa_TerminoPago] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdCbteVta] ASC, [IdTerminoPago] ASC, [Secuencia] ASC)
);

