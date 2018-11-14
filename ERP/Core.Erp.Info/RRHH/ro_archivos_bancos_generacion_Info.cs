using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
   public class ro_archivos_bancos_generacion_Info
    {


        public decimal IdTransaccionSession { get; set; }
        public int IdEmpresa { get; set; }
        public decimal IdArchivo { get; set; }
        public int IdNomina { get; set; }
        public int IdNominaTipo { get; set; }
        public int IdPeriodo { get; set; }
        public Nullable<int> IdCuentaBancaria { get; set; }
        public string IdProceso_Bancario { get; set; }
        public string Cod_Empresa { get; set; }
        public string Nom_Archivo { get; set; }
        public byte[] archivo { get; set; }
        public string estado { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public decimal IdRol { get; set; }
        public string MotiAnula { get; set; }
        public bool EstadoBool { get; set; }

        public List < ro_archivos_bancos_generacion_x_empleado_Info> detalle { get; set; }

      public  ro_archivos_bancos_generacion_Info()
        {
            detalle = new List<ro_archivos_bancos_generacion_x_empleado_Info>();
        }

    }
}
