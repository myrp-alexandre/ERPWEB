CREATE TABLE [dbo].[in_moviInventario_x_GestionProdLaminados_Cus_Talme] (
    [mov_IdEmpresa]            INT          NOT NULL,
    [mov_IdSucursal]           INT          NOT NULL,
    [mov_IdBodega]             INT          NOT NULL,
    [mov_IdMovi_inven_tipo]    INT          NOT NULL,
    [mov_IdNumMovi]            NUMERIC (10) NOT NULL,
    [prod_IdEmpresa]           INT          NOT NULL,
    [prod_IdGestionProductiva] NUMERIC (18) NOT NULL,
    CONSTRAINT [PK_in_moviInventario_x_GestionProdLaminados_Cus_Talme] PRIMARY KEY CLUSTERED ([mov_IdEmpresa] ASC, [mov_IdSucursal] ASC, [mov_IdBodega] ASC, [mov_IdMovi_inven_tipo] ASC, [mov_IdNumMovi] ASC, [prod_IdEmpresa] ASC, [prod_IdGestionProductiva] ASC)
);

