//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class imp_orden_compra_ext_ct_cbteble_det_gastos
    {
        public int IdEmpresa { get; set; }
        public decimal IdOrdenCompra_ext { get; set; }
        public int IdEmpresa_ct { get; set; }
        public int IdTipoCbte { get; set; }
        public decimal IdCbteCble { get; set; }
        public int secuencia_ct { get; set; }
        public Nullable<int> IdGasto_tipo { get; set; }
    
        public virtual imp_gasto imp_gasto { get; set; }
        public virtual imp_orden_compra_ext imp_orden_compra_ext { get; set; }
    }
}