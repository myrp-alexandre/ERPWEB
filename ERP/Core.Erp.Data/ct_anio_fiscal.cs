//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Core.Erp.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class ct_anio_fiscal
    {
        public ct_anio_fiscal()
        {
            this.ct_anio_fiscal_x_cuenta_utilidad = new HashSet<ct_anio_fiscal_x_cuenta_utilidad>();
            this.ct_periodo = new HashSet<ct_periodo>();
        }
    
        public int IdanioFiscal { get; set; }
        public System.DateTime af_fechaIni { get; set; }
        public System.DateTime af_fechaFin { get; set; }
        public string af_estado { get; set; }
    
        public virtual ICollection<ct_anio_fiscal_x_cuenta_utilidad> ct_anio_fiscal_x_cuenta_utilidad { get; set; }
        public virtual ICollection<ct_periodo> ct_periodo { get; set; }
    }
}
