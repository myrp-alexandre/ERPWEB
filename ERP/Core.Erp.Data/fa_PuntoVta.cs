//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class fa_PuntoVta
    {
        public fa_PuntoVta()
        {
            this.fa_factura = new HashSet<fa_factura>();
            this.fa_notaCreDeb = new HashSet<fa_notaCreDeb>();
        }
    
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdPuntoVta { get; set; }
        public string cod_PuntoVta { get; set; }
        public string nom_PuntoVta { get; set; }
        public bool estado { get; set; }
        public int IdBodega { get; set; }
        public int IdCaja { get; set; }
        public string IPImpresora { get; set; }
    
        public virtual ICollection<fa_factura> fa_factura { get; set; }
        public virtual ICollection<fa_notaCreDeb> fa_notaCreDeb { get; set; }
    }
}
