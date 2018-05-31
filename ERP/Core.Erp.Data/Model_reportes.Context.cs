﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Core.Erp.Data
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class Entities_reportes : DbContext
    {
        public Entities_reportes()
            : base("name=Entities_reportes")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<VWCONTA_001> VWCONTA_001 { get; set; }
        public virtual DbSet<VWACTF_001> VWACTF_001 { get; set; }
        public virtual DbSet<VWACTF_002> VWACTF_002 { get; set; }
        public virtual DbSet<VWACTF_003> VWACTF_003 { get; set; }
        public virtual DbSet<VWINV_001> VWINV_001 { get; set; }
        public virtual DbSet<VWINV_002> VWINV_002 { get; set; }
        public virtual DbSet<VWCAJ_001> VWCAJ_001 { get; set; }
        public virtual DbSet<VWROL_001> VWROL_001 { get; set; }
    
        public virtual ObjectResult<SPINV_003_Result> SPINV_003(Nullable<int> idEmpresa, Nullable<int> idSucursal_ini, Nullable<int> idSucursal_fin, Nullable<int> idBodega_ini, Nullable<int> idBodega_fin, Nullable<decimal> idProducto_ini, Nullable<decimal> idProducto_fin, string idCategoria, Nullable<int> idLinea, Nullable<int> idGrupo, Nullable<int> idSubGrupo, Nullable<System.DateTime> fecha_corte, Nullable<bool> mostrar_stock_0)
        {
            var idEmpresaParameter = idEmpresa.HasValue ?
                new ObjectParameter("IdEmpresa", idEmpresa) :
                new ObjectParameter("IdEmpresa", typeof(int));
    
            var idSucursal_iniParameter = idSucursal_ini.HasValue ?
                new ObjectParameter("IdSucursal_ini", idSucursal_ini) :
                new ObjectParameter("IdSucursal_ini", typeof(int));
    
            var idSucursal_finParameter = idSucursal_fin.HasValue ?
                new ObjectParameter("IdSucursal_fin", idSucursal_fin) :
                new ObjectParameter("IdSucursal_fin", typeof(int));
    
            var idBodega_iniParameter = idBodega_ini.HasValue ?
                new ObjectParameter("IdBodega_ini", idBodega_ini) :
                new ObjectParameter("IdBodega_ini", typeof(int));
    
            var idBodega_finParameter = idBodega_fin.HasValue ?
                new ObjectParameter("IdBodega_fin", idBodega_fin) :
                new ObjectParameter("IdBodega_fin", typeof(int));
    
            var idProducto_iniParameter = idProducto_ini.HasValue ?
                new ObjectParameter("IdProducto_ini", idProducto_ini) :
                new ObjectParameter("IdProducto_ini", typeof(decimal));
    
            var idProducto_finParameter = idProducto_fin.HasValue ?
                new ObjectParameter("IdProducto_fin", idProducto_fin) :
                new ObjectParameter("IdProducto_fin", typeof(decimal));
    
            var idCategoriaParameter = idCategoria != null ?
                new ObjectParameter("IdCategoria", idCategoria) :
                new ObjectParameter("IdCategoria", typeof(string));
    
            var idLineaParameter = idLinea.HasValue ?
                new ObjectParameter("IdLinea", idLinea) :
                new ObjectParameter("IdLinea", typeof(int));
    
            var idGrupoParameter = idGrupo.HasValue ?
                new ObjectParameter("IdGrupo", idGrupo) :
                new ObjectParameter("IdGrupo", typeof(int));
    
            var idSubGrupoParameter = idSubGrupo.HasValue ?
                new ObjectParameter("IdSubGrupo", idSubGrupo) :
                new ObjectParameter("IdSubGrupo", typeof(int));
    
            var fecha_corteParameter = fecha_corte.HasValue ?
                new ObjectParameter("fecha_corte", fecha_corte) :
                new ObjectParameter("fecha_corte", typeof(System.DateTime));
    
            var mostrar_stock_0Parameter = mostrar_stock_0.HasValue ?
                new ObjectParameter("mostrar_stock_0", mostrar_stock_0) :
                new ObjectParameter("mostrar_stock_0", typeof(bool));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<SPINV_003_Result>("SPINV_003", idEmpresaParameter, idSucursal_iniParameter, idSucursal_finParameter, idBodega_iniParameter, idBodega_finParameter, idProducto_iniParameter, idProducto_finParameter, idCategoriaParameter, idLineaParameter, idGrupoParameter, idSubGrupoParameter, fecha_corteParameter, mostrar_stock_0Parameter);
        }
    }
}
