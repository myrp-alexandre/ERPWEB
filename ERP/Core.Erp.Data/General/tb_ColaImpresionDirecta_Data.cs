using Core.Erp.Info.General;
using System;
using System.Linq;

namespace Core.Erp.Data.General
{
    public class tb_ColaImpresionDirecta_Data
    {
        public bool GuardarDB(tb_ColaImpresionDirecta_Info info)
        {
            try
            {
                using (Entities_general db = new Entities_general())
                {
                    db.tb_ColaImpresionDirecta.Add(new tb_ColaImpresionDirecta
                    {
                        IdEmpresa = info.IdEmpresa,
                        CodReporte = info.CodReporte,
                        IPUsuario = info.IPUsuario,
                        IPMaquina = info.IPMaquina,
                        Parametros = info.Parametros,
                        Usuario = info.Usuario,
                        NombreEmpresa = info.NombreEmpresa,
                        FechaEnvio = DateTime.Now                        
                    });
                }
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public tb_ColaImpresionDirecta_Info GetInfoPorImprimir(string IPMaquina)
        {
            try
            {
                using (Entities_general db = new Entities_general())
                {
                    var entity = db.tb_ColaImpresionDirecta.Where(q => q.IPMaquina == IPMaquina && q.FechaImpresion == null).FirstOrDefault();
                    if (entity == null)
                        return null;
                    return new tb_ColaImpresionDirecta_Info
                    {
                        IdEmpresa = entity.IdEmpresa,
                        IdImpresion = entity.IdImpresion,
                        CodReporte = entity.CodReporte,
                        IPUsuario = entity.IPUsuario,
                        IPMaquina = entity.IPMaquina,
                        Parametros = entity.Parametros,
                        Usuario = entity.Usuario,
                        NombreEmpresa = entity.NombreEmpresa,
                        FechaEnvio = entity.FechaEnvio,
                        FechaImpresion = entity.FechaImpresion,
                        Comentario = entity.Comentario
                    };
                }
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
