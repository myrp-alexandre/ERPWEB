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
    
    public partial class Entities_banco : DbContext
    {
        public Entities_banco()
            : base("name=Entities_banco")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<ba_CatalogoTipo> ba_CatalogoTipo { get; set; }
        public virtual DbSet<ba_parametros> ba_parametros { get; set; }
        public virtual DbSet<ba_Banco_Cuenta> ba_Banco_Cuenta { get; set; }
        public virtual DbSet<ba_Catalogo> ba_Catalogo { get; set; }
        public virtual DbSet<ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito> ba_Caja_Movimiento_x_Cbte_Ban_x_Deposito { get; set; }
        public virtual DbSet<ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo> ba_Cbte_Ban_tipo_x_ct_CbteCble_tipo { get; set; }
        public virtual DbSet<ba_Talonario_cheques_x_banco> ba_Talonario_cheques_x_banco { get; set; }
        public virtual DbSet<ba_tipo_nota> ba_tipo_nota { get; set; }
        public virtual DbSet<ba_Cbte_Ban> ba_Cbte_Ban { get; set; }
        public virtual DbSet<vwba_Cbte_Ban> vwba_Cbte_Ban { get; set; }
        public virtual DbSet<vwba_Talonario_cheques_x_banco_ID> vwba_Talonario_cheques_x_banco_ID { get; set; }
    }
}
