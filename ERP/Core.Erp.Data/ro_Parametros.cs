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
    
    public partial class ro_Parametros
    {
        public int IdEmpresa { get; set; }
        public int IdTipoCbte_AsientoSueldoXPagar { get; set; }
        public double Sueldo_basico { get; set; }
        public double Porcentaje_aporte_pers { get; set; }
        public double Porcentaje_aporte_patr { get; set; }
        public string IdRubro_acta_finiquito { get; set; }
        public bool genera_op_x_pago { get; set; }
        public bool Genera_op_x_pago_x_empleao { get; set; }
        public bool Genera_op_por_liq_vacaciones { get; set; }
        public bool Genera_op_por_acta_finiquito { get; set; }
        public bool Genera_op_por_prestamos { get; set; }
        public string IdTipo_op_vacaciones { get; set; }
        public string IdTipo_op_prestamos { get; set; }
        public string IdTipo_op_acta_finiquito { get; set; }
        public string IdTipo_op_sueldo_por_pagar { get; set; }
        public string EstadoCreacionPrestamos { get; set; }
    
        public virtual ro_catalogo ro_catalogo { get; set; }
    }
}
