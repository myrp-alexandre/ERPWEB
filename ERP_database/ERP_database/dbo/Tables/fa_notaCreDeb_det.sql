CREATE TABLE [dbo].[fa_notaCreDeb_det] (
    [IdEmpresa]                      INT            NOT NULL,
    [IdSucursal]                     INT            NOT NULL,
    [IdBodega]                       INT            NOT NULL,
    [IdNota]                         NUMERIC (18)   NOT NULL,
    [Secuencia]                      INT            NOT NULL,
    [IdProducto]                     NUMERIC (18)   NOT NULL,
    [sc_cantidad]                    FLOAT (53)     NOT NULL,
    [sc_Precio]                      FLOAT (53)     NOT NULL,
    [sc_descUni]                     FLOAT (53)     NOT NULL,
    [sc_PordescUni]                  FLOAT (53)     NOT NULL,
    [sc_precioFinal]                 FLOAT (53)     NOT NULL,
    [sc_subtotal]                    FLOAT (53)     NOT NULL,
    [sc_iva]                         FLOAT (53)     NOT NULL,
    [sc_total]                       FLOAT (53)     NOT NULL,
    [sc_costo]                       FLOAT (53)     NOT NULL,
    [sc_observacion]                 VARCHAR (1000) NULL,
    [sc_estado]                      CHAR (1)       NOT NULL,
    [vt_por_iva]                     FLOAT (53)     NOT NULL,
    [IdPunto_Cargo]                  INT            NULL,
    [IdPunto_cargo_grupo]            INT            NULL,
    [IdCod_Impuesto_Iva]             VARCHAR (25)   NOT NULL,
    [IdCod_Impuesto_Ice]             VARCHAR (25)   NULL,
    [IdCentroCosto]                  VARCHAR (20)   NULL,
    [IdCentroCosto_sub_centro_costo] VARCHAR (20)   NULL,
    [sc_cantidad_factura]            FLOAT (53)     NULL,
    CONSTRAINT [PK_fa_notaCreDeb_det] PRIMARY KEY CLUSTERED ([IdEmpresa] ASC, [IdSucursal] ASC, [IdBodega] ASC, [IdNota] ASC, [Secuencia] ASC),
    CONSTRAINT [FK_fa_notaCreDeb_det_fa_notaCreDeb] FOREIGN KEY ([IdEmpresa], [IdSucursal], [IdBodega], [IdNota]) REFERENCES [dbo].[fa_notaCreDeb] ([IdEmpresa], [IdSucursal], [IdBodega], [IdNota]),
    CONSTRAINT [FK_fa_notaCreDeb_det_in_Producto] FOREIGN KEY ([IdEmpresa], [IdProducto]) REFERENCES [dbo].[in_Producto] ([IdEmpresa], [IdProducto]),
    CONSTRAINT [FK_fa_notaCreDeb_det_tb_sis_Impuesto] FOREIGN KEY ([IdCod_Impuesto_Iva]) REFERENCES [dbo].[tb_sis_Impuesto] ([IdCod_Impuesto]),
    CONSTRAINT [FK_fa_notaCreDeb_det_tb_sis_Impuesto1] FOREIGN KEY ([IdCod_Impuesto_Ice]) REFERENCES [dbo].[tb_sis_Impuesto] ([IdCod_Impuesto])
);





