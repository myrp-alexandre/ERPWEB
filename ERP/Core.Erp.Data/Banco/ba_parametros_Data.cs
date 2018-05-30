using Core.Erp.Info.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Banco
{
    public class ba_parametros_Data
    {
        public ba_parametros_Info get_info(int IdEmpresa)
        {
            try
            {
                ba_parametros_Info info = new ba_parametros_Info();
                using (Entities_banco Context = new Entities_banco())
                {
                    ba_parametros Entity = Context.ba_parametros.FirstOrDefault(q => q.IdEmpresa == IdEmpresa);
                    if (Entity == null) return null;
                    info = new ba_parametros_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        CiudadDefaultParaCrearCheques = Entity.CiudadDefaultParaCrearCheques,
                        El_Diario_Contable_es_modificable = Entity.El_Diario_Contable_es_modificable,
                        IdCtaCble_Interes = Entity.IdCtaCble_Interes,
                        IdCtaCble_prestamos = Entity.IdCtaCble_prestamos,
                        IdTipoCbte_x_Prestamo = Entity.IdTipoCbte_x_Prestamo,
                        IdTipoNota_ND_Can_Cuotas = Entity.IdTipoNota_ND_Can_Cuotas,
                        Ruta_descarga_fila_x_PreAviso_cheq = Entity.Ruta_descarga_fila_x_PreAviso_cheq
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public bool guardarDB(ba_parametros_Info info)
        {
            try
            {
                using (Entities_banco Context = new Entities_banco())
                {
                    ba_parametros Entity = Context.ba_parametros.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa);
                    if (Entity == null)
                    {
                        Entity = new ba_parametros
                        {

                            IdEmpresa = info.IdEmpresa,
                            CiudadDefaultParaCrearCheques = info.CiudadDefaultParaCrearCheques,
                            El_Diario_Contable_es_modificable = info.El_Diario_Contable_es_modificable,
                            IdCtaCble_Interes = info.IdCtaCble_Interes,
                            IdCtaCble_prestamos = info.IdCtaCble_prestamos,
                            IdTipoCbte_x_Prestamo = info.IdTipoCbte_x_Prestamo,
                            IdTipoNota_ND_Can_Cuotas = info.IdTipoNota_ND_Can_Cuotas,
                            Ruta_descarga_fila_x_PreAviso_cheq = info.Ruta_descarga_fila_x_PreAviso_cheq,
                            IdUsuario = info.IdUsuario
                        };
                        Context.ba_parametros.Add(Entity);
                    }
                        else
                        {
                        Entity.CiudadDefaultParaCrearCheques = info.CiudadDefaultParaCrearCheques;
                        Entity.El_Diario_Contable_es_modificable = info.El_Diario_Contable_es_modificable;
                        Entity.IdCtaCble_Interes = info.IdCtaCble_Interes;
                        Entity.IdCtaCble_prestamos = info.IdCtaCble_prestamos;
                        Entity.IdTipoCbte_x_Prestamo = info.IdTipoCbte_x_Prestamo;
                        Entity.IdTipoNota_ND_Can_Cuotas = info.IdTipoNota_ND_Can_Cuotas;
                        Entity.Ruta_descarga_fila_x_PreAviso_cheq = info.Ruta_descarga_fila_x_PreAviso_cheq;

                        Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;

                    }
                    Context.SaveChanges();
                }
                    return true;
                }
            catch (Exception)
            {
                throw;
            }
        }
    }
}
