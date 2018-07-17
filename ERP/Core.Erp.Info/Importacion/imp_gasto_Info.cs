using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Importacion
{
    public class imp_gasto_Info
    {
        public int IdGasto_tipo { get; set; }
        public string gt_descripcion { get; set; }
        public bool estado { get; set; }
        public string observacion { get; set; }

        #region Campos que no existen en la tabla

        public imp_gasto_x_ct_plancta_Info info_gasto_cta { get; set; }
        public string IdCtaCble { get; set; }
        #endregion


    }
}
