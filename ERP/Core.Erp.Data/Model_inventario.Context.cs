﻿//------------------------------------------------------------------------------
// <auto-generated>
//    Este código se generó a partir de una plantilla.
//
//    Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//    Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Core.Erp.Data
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;

    public partial class Entities_inventario : DbContext
    {
        public Entities_inventario()
            : base("name=Entities_inventario")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<in_Catalogo> in_Catalogo { get; set; }
        public DbSet<in_CatalogoTipo> in_CatalogoTipo { get; set; }
        public DbSet<in_categorias> in_categorias { get; set; }
        public DbSet<in_devolucion_inven> in_devolucion_inven { get; set; }
        public DbSet<in_devolucion_inven_det> in_devolucion_inven_det { get; set; }
        public DbSet<in_grupo> in_grupo { get; set; }
        public DbSet<in_Ing_Egr_Inven> in_Ing_Egr_Inven { get; set; }
        public DbSet<in_Ing_Egr_Inven_det> in_Ing_Egr_Inven_det { get; set; }
        public DbSet<in_Ing_Egr_Inven_distribucion> in_Ing_Egr_Inven_distribucion { get; set; }
        public DbSet<in_linea> in_linea { get; set; }
        public DbSet<in_Marca> in_Marca { get; set; }
        public DbSet<in_Motivo_Inven> in_Motivo_Inven { get; set; }
        public DbSet<in_movi_inven_tipo> in_movi_inven_tipo { get; set; }
        public DbSet<in_movi_inven_tipo_x_tb_bodega> in_movi_inven_tipo_x_tb_bodega { get; set; }
        public DbSet<in_parametro> in_parametro { get; set; }
        public DbSet<in_presentacion> in_presentacion { get; set; }
        public DbSet<in_Producto> in_Producto { get; set; }
        public DbSet<in_Producto_Composicion> in_Producto_Composicion { get; set; }
        public DbSet<in_producto_x_tb_bodega_Costo_Historico> in_producto_x_tb_bodega_Costo_Historico { get; set; }
        public DbSet<in_subgrupo> in_subgrupo { get; set; }
        public DbSet<in_transferencia> in_transferencia { get; set; }
        public DbSet<in_transferencia_det> in_transferencia_det { get; set; }
        public DbSet<in_UnidadMedida> in_UnidadMedida { get; set; }
        public DbSet<in_UnidadMedida_Equiv_conversion> in_UnidadMedida_Equiv_conversion { get; set; }
        public DbSet<vwin_devolucion_inven_det> vwin_devolucion_inven_det { get; set; }
        public DbSet<vwin_Ing_Egr_Inven_distribucion> vwin_Ing_Egr_Inven_distribucion { get; set; }
        public DbSet<vwin_Ing_Egr_Inven_distribucion_det> vwin_Ing_Egr_Inven_distribucion_det { get; set; }
        public DbSet<vwin_Ing_Egr_Inven_distribucion_x_distribuir> vwin_Ing_Egr_Inven_distribucion_x_distribuir { get; set; }
        public DbSet<vwin_Transferencias> vwin_Transferencias { get; set; }
        public DbSet<vwin_Ing_Egr_Inven_det> vwin_Ing_Egr_Inven_det { get; set; }
        public DbSet<vwin_Ing_Egr_Inven_det_x_devolver> vwin_Ing_Egr_Inven_det_x_devolver { get; set; }
        public DbSet<vwin_Ing_Egr_Inven_por_devolver> vwin_Ing_Egr_Inven_por_devolver { get; set; }
        public DbSet<vwin_Producto_Composicion> vwin_Producto_Composicion { get; set; }
        public DbSet<vwin_producto_hijo_combo> vwin_producto_hijo_combo { get; set; }
        public DbSet<vwin_producto_padre_combo> vwin_producto_padre_combo { get; set; }
        public DbSet<vwin_producto_x_tb_bodega_stock_x_lote> vwin_producto_x_tb_bodega_stock_x_lote { get; set; }
        public DbSet<vwin_Producto_Stock> vwin_Producto_Stock { get; set; }
        public DbSet<in_producto_x_tb_bodega> in_producto_x_tb_bodega { get; set; }
        public DbSet<in_ProductoTipo> in_ProductoTipo { get; set; }
        public DbSet<In_consignacion> In_consignacion { get; set; }
        public DbSet<in_consignacion_det> in_consignacion_det { get; set; }
        public DbSet<vwin_consignacion> vwin_consignacion { get; set; }
    
        public virtual ObjectResult<spSys_inv_Reversar_aprobacion_Result> spSys_inv_Reversar_aprobacion(Nullable<int> idEmpresa, Nullable<int> idSucursal, Nullable<int> idMovi_inven_tipo, Nullable<decimal> idNumMovi, Nullable<bool> borar)
        {
            var idEmpresaParameter = idEmpresa.HasValue ?
                new ObjectParameter("IdEmpresa", idEmpresa) :
                new ObjectParameter("IdEmpresa", typeof(int));
    
            var idSucursalParameter = idSucursal.HasValue ?
                new ObjectParameter("IdSucursal", idSucursal) :
                new ObjectParameter("IdSucursal", typeof(int));
    
            var idMovi_inven_tipoParameter = idMovi_inven_tipo.HasValue ?
                new ObjectParameter("IdMovi_inven_tipo", idMovi_inven_tipo) :
                new ObjectParameter("IdMovi_inven_tipo", typeof(int));
    
            var idNumMoviParameter = idNumMovi.HasValue ?
                new ObjectParameter("IdNumMovi", idNumMovi) :
                new ObjectParameter("IdNumMovi", typeof(decimal));
    
            var borarParameter = borar.HasValue ?
                new ObjectParameter("Borar", borar) :
                new ObjectParameter("Borar", typeof(bool));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spSys_inv_Reversar_aprobacion_Result>("spSys_inv_Reversar_aprobacion", idEmpresaParameter, idSucursalParameter, idMovi_inven_tipoParameter, idNumMoviParameter, borarParameter);
        }
    
        public virtual ObjectResult<string> spin_Producto_validar_anulacion(Nullable<int> idEmpresa, Nullable<decimal> idProducto)
        {
            var idEmpresaParameter = idEmpresa.HasValue ?
                new ObjectParameter("IdEmpresa", idEmpresa) :
                new ObjectParameter("IdEmpresa", typeof(int));
    
            var idProductoParameter = idProducto.HasValue ?
                new ObjectParameter("IdProducto", idProducto) :
                new ObjectParameter("IdProducto", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<string>("spin_Producto_validar_anulacion", idEmpresaParameter, idProductoParameter);
        }
    
        public virtual int spINV_aprobacion_ing_egr(Nullable<int> idEmpresa, Nullable<int> idSucursal, Nullable<int> idBodega, Nullable<int> idMovi_inven_tipo, Nullable<decimal> idNumMovi)
        {
            var idEmpresaParameter = idEmpresa.HasValue ?
                new ObjectParameter("IdEmpresa", idEmpresa) :
                new ObjectParameter("IdEmpresa", typeof(int));
    
            var idSucursalParameter = idSucursal.HasValue ?
                new ObjectParameter("IdSucursal", idSucursal) :
                new ObjectParameter("IdSucursal", typeof(int));
    
            var idBodegaParameter = idBodega.HasValue ?
                new ObjectParameter("IdBodega", idBodega) :
                new ObjectParameter("IdBodega", typeof(int));
    
            var idMovi_inven_tipoParameter = idMovi_inven_tipo.HasValue ?
                new ObjectParameter("IdMovi_inven_tipo", idMovi_inven_tipo) :
                new ObjectParameter("IdMovi_inven_tipo", typeof(int));
    
            var idNumMoviParameter = idNumMovi.HasValue ?
                new ObjectParameter("IdNumMovi", idNumMovi) :
                new ObjectParameter("IdNumMovi", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spINV_aprobacion_ing_egr", idEmpresaParameter, idSucursalParameter, idBodegaParameter, idMovi_inven_tipoParameter, idNumMoviParameter);
        }
    }
}
