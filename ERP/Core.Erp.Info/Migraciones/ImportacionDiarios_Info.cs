using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Migraciones
{
    public class ImportacionDiarios_Info
    {
        public string Empresa { get; set; }
        public string centro { get; set; }
        public int Numero { get; set; }
        public int Secuencia { get; set; }
        public string Fecha { get; set; }
        public string Grupo { get; set; }
        public string SubGrupo { get; set; }
        public string Cuenta { get; set; }
        public string SubCuenta { get; set; }
        public string SubCuenta1 { get; set; }
        public string SubCuenta2 { get; set; }
        public Nullable<decimal> Valor { get; set; }
        public string TipoMov { get; set; }
        public string Glosa { get; set; }
        public string Detalle { get; set; }
        public string tipo_documento { get; set; }
        public string IdCtaCble { get; set; }
        public Nullable<decimal> dc_Valor { get; set; }
    }
}
