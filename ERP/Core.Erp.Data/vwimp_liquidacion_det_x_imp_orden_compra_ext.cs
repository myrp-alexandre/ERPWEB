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
    
    public partial class vwimp_liquidacion_det_x_imp_orden_compra_ext
    {
        public int IdEmpresa { get; set; }
        public decimal IdLiquidacion { get; set; }
        public int IdEmpresa_oe { get; set; }
        public decimal IdOrdenCompra_ext { get; set; }
        public string observacion { get; set; }
        public string oe_observacion { get; set; }
        public System.DateTime oe_fecha { get; set; }
        public string pe_cedulaRuc { get; set; }
        public string pe_nombreCompleto { get; set; }
        public Nullable<int> IdMoneda_origen { get; set; }
        public Nullable<int> IdMoneda_destino { get; set; }
        public bool Estado_cierre { get; set; }
        public string IdPais_embarque { get; set; }
        public string IdCiudad_destino { get; set; }
        public int IdCatalogo_via { get; set; }
        public int IdCatalogo_forma_pago { get; set; }
    }
}
