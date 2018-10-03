using Core.Erp.Info.Banco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Banco
{
    public class ba_Banco_Cuenta_Data
    {
        public List<ba_Banco_Cuenta_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<ba_Banco_Cuenta_Info> Lista;
                using (Entities_banco Context = new Entities_banco())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.ba_Banco_Cuenta
                                 where q.IdEmpresa == IdEmpresa
                                 select new ba_Banco_Cuenta_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                      ba_descripcion = q.ba_descripcion,
                                      ba_Num_Cuenta = q.ba_Num_Cuenta,
                                      ba_num_digito_cheq = q.ba_num_digito_cheq,
                                      ba_Tipo = q.ba_Tipo,
                                      Estado = q.Estado,
                                      IdBanco = q.IdBanco,
                                      IdCtaCble = q.IdCtaCble,
                                      ReporteSolo_Cheque = q.ReporteSolo_Cheque,

                                     EstadoBool = q.Estado == "A" ? true : false

                                 }).ToList();
                    else
                        Lista = (from q in Context.ba_Banco_Cuenta
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 select new ba_Banco_Cuenta_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     ba_descripcion = q.ba_descripcion,
                                     ba_Num_Cuenta = q.ba_Num_Cuenta,
                                     ba_num_digito_cheq = q.ba_num_digito_cheq,
                                     ba_Tipo = q.ba_Tipo,
                                     Estado = q.Estado,
                                     IdBanco = q.IdBanco,
                                     IdCtaCble = q.IdCtaCble,
                                     ReporteSolo_Cheque = q.ReporteSolo_Cheque,

                                     EstadoBool = q.Estado == "A" ? true : false

                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public ba_Banco_Cuenta_Info get_info(int IdEmpresa, int idBanco)
        {
            try
            {
                ba_Banco_Cuenta_Info info = new ba_Banco_Cuenta_Info();
                using (Entities_banco Context = new Entities_banco())
                {
                    ba_Banco_Cuenta Entity = Context.ba_Banco_Cuenta.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdBanco == idBanco);
                    if (Entity == null) return null;
                    info = new ba_Banco_Cuenta_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        ba_descripcion = Entity.ba_descripcion,
                        ba_Num_Cuenta = Entity.ba_Num_Cuenta,
                        ba_num_digito_cheq = Entity.ba_num_digito_cheq,
                        ba_Tipo = Entity.ba_Tipo,
                        Estado = Entity.Estado,
                        IdBanco = Entity.IdBanco,
                        IdCtaCble = Entity.IdCtaCble,
                        ReporteSolo_Cheque = Entity.ReporteSolo_Cheque,
                        MostrarVistaPreviaCheque = Entity.MostrarVistaPreviaCheque == Convert.ToBoolean(Entity.MostrarVistaPreviaCheque),
                        Imprimir_Solo_el_cheque = Entity.Imprimir_Solo_el_cheque == Convert.ToBoolean(Entity.Imprimir_Solo_el_cheque),
                        IdBanco_Financiero = Entity.IdBanco_Financiero,
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int get_id(int IdEmpresa)
        {
            try
            {
                int ID = 1;
                using (Entities_banco Context =  new Entities_banco())
                {
                    var lst = from q in Context.ba_Banco_Cuenta
                              where q.IdEmpresa == IdEmpresa
                              select q;
                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdBanco) + 1;
                }
                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(ba_Banco_Cuenta_Info info)
        {
            try
            {
                using (Entities_banco Context = new Entities_banco())
                {
                    ba_Banco_Cuenta Entity = new ba_Banco_Cuenta
                    {
                        IdEmpresa = info.IdEmpresa,
                        Estado = info.Estado = "A",
                        IdBanco = info.IdBanco = get_id(info.IdEmpresa),
                        ba_descripcion = info.ba_descripcion,
                        ba_Num_Cuenta = info.ba_Num_Cuenta,
                        ba_num_digito_cheq = info.ba_num_digito_cheq,
                        ba_Tipo = info.ba_Tipo,
                        IdCtaCble = info.IdCtaCble,
                        ReporteSolo_Cheque = info.ReporteSolo_Cheque,
                        MostrarVistaPreviaCheque = info.MostrarVistaPreviaCheque == Convert.ToBoolean(info.MostrarVistaPreviaCheque),
                        Imprimir_Solo_el_cheque = info.Imprimir_Solo_el_cheque == Convert.ToBoolean(info.Imprimir_Solo_el_cheque),
                        IdBanco_Financiero = info.IdBanco_Financiero,
                        

                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now
                    };
                    Context.ba_Banco_Cuenta.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(ba_Banco_Cuenta_Info info)
        {
            try
            {
                using (Entities_banco Context = new Entities_banco())
                {
                    ba_Banco_Cuenta Entity = Context.ba_Banco_Cuenta.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdBanco == info.IdBanco);
                    if (Entity == null) return false;

                    Entity.ba_descripcion = info.ba_descripcion;
                    Entity.ba_Num_Cuenta = info.ba_Num_Cuenta;
                    Entity.ba_num_digito_cheq = info.ba_num_digito_cheq;
                    Entity.ba_Tipo = info.ba_Tipo;
                    Entity.IdCtaCble = info.IdCtaCble;
                    Entity.ReporteSolo_Cheque = info.ReporteSolo_Cheque;
                    Entity.IdBanco_Financiero = info.IdBanco_Financiero;
                    Entity.MostrarVistaPreviaCheque = info.MostrarVistaPreviaCheque == Convert.ToBoolean(info.MostrarVistaPreviaCheque);
                    Entity.Imprimir_Solo_el_cheque = info.Imprimir_Solo_el_cheque == Convert.ToBoolean(info.Imprimir_Solo_el_cheque);

                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(ba_Banco_Cuenta_Info info)
        {
            try
            {
                using (Entities_banco Context = new Entities_banco())
                {
                    ba_Banco_Cuenta Entity = Context.ba_Banco_Cuenta.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdBanco == info.IdBanco);
                    if (Entity == null) return false;

                    Entity.Estado = info.Estado="I";

                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = DateTime.Now;
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
