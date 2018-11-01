CREATE TABLE [dbo].[tbINV_Rpt021] (
    [IdEmpresa]         INT           NULL,
    [IdSucursal]        INT           NULL,
    [IdBodega]          INT           NULL,
    [Idproducto]        NUMERIC (18)  NULL,
    [cod_producto]      VARCHAR (50)  NULL,
    [nom_producto]      VARCHAR (150) NULL,
    [egresos]           FLOAT (53)    NULL,
    [stock_fecha_desde] FLOAT (53)    NULL,
    [stock_fecha_hasta] FLOAT (53)    NULL,
    [promedio]          FLOAT (53)    NULL,
    [indice]            FLOAT (53)    NULL,
    [stock_minimo]      FLOAT (53)    NULL,
    [stock_hoy]         FLOAT (53)    NULL,
    [cant_a_comprar]    FLOAT (53)    NULL,
    [nom_bodega]        VARCHAR (50)  NULL,
    [nom_sucursal]      VARCHAR (50)  NULL
);

