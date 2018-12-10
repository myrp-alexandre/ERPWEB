using Core.Erp.Data.Presupuesto;
using Core.Erp.Info.Presupuesto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Bus.Presupuesto
{
    public class pre_Grupo_x_seg_usuario_Bus
    {
        pre_Grupo_x_seg_usuario_Data odata_det = new pre_Grupo_x_seg_usuario_Data();

        public List<pre_Grupo_x_seg_usuario_Info> GetList(int IdEmpresa, int IdGrupo)
        {
            try
            {
                return odata_det.GetList(IdEmpresa, IdGrupo);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public pre_Grupo_x_seg_usuario_Info GetInfoPermiso(int IdEmpresa, string IdUsuario)
        {
            try
            {
                return odata_det.GetInfoPermiso(IdEmpresa, IdUsuario);
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
