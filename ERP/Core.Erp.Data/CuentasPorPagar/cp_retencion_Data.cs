using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.CuentasPorPagar;
namespace Core.Erp.Data.CuentasPorPagar
{
   public class cp_retencion_Data
    {


        public List<cp_retencion_Info> get_list(int IdEmpresa, DateTime Fechaini, DateTime FechaFin)
        {
            try
            {

                Fechaini = Convert.ToDateTime(Fechaini.ToShortDateString());
                FechaFin = Convert.ToDateTime(FechaFin.ToShortDateString());
                List<cp_retencion_Info> lista = new List<cp_retencion_Info>();
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    lista = (from item in Context.vwcp_retencion
                             where item.IdEmpresa == IdEmpresa
                             && item.fecha>=Fechaini
                             && item.fecha<=FechaFin
                             select new cp_retencion_Info
                             {

                                 IdEmpresa = item.IdEmpresa,
                                 IdRetencion = item.IdRetencion,
                                 pe_apellido = item.pe_apellido,
                                 pe_nombre = item.pe_nombre,
                                 pe_razonSocial = item.pe_razonSocial,
                                 NumRetencion = item.NumRetencion,
                                 serie1 = item.serie1,
                                 serie2 = item.serie2,
                                 co_serie = item.co_serie,
                                 co_factura = item.co_factura,
                                 co_baseImponible = item.co_baseImponible,
                                 Estado = item.Estado,
                                 pe_nombreCompleto=item.pe_nombreCompleto,

                                 EstadoBool = item.Estado == "A" ? true : false

                             }).ToList();
                }

                return lista;
            }
            catch (Exception )
            {
               
                throw ;
            }
        }
        public cp_retencion_Info get_info(int IdEmpresa, decimal IdRetencion)
        {
            try
            {
                cp_retencion_Info info = new cp_retencion_Info();
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    vwcp_retencion Entity = Context.vwcp_retencion.FirstOrDefault(q => q.IdEmpresa == IdEmpresa & q.IdRetencion==IdRetencion);
                    if (Entity == null) return null;
                    info = new cp_retencion_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdProveedor=Entity.IdProveedor,
                        ct_IdTipoCbte = Entity.ct_IdTipoCbte,
                        ct_IdCbteCble = Entity.ct_IdCbteCble,
                        IdRetencion = Entity.IdRetencion ,
                        CodDocumentoTipo = Entity.CodDocumentoTipo,
                        serie1 = Entity.serie1,
                        serie2 = Entity.serie2,
                        NumRetencion = Entity.NumRetencion,
                        NAutorizacion = Entity.NAutorizacion,
                        observacion = Entity.observacion,
                        fecha = Convert.ToDateTime(Entity.fecha.ToShortDateString()),
                        re_Tiene_RTiva = Entity.re_Tiene_RTiva,
                        re_Tiene_RFuente = Entity.re_Tiene_RFuente,
                        co_baseImponible=Entity.co_baseImponible,
                        co_serie=Entity.co_serie,
                        co_factura=Entity.co_factura,
                        co_subtotal_iva=Entity.co_subtotal_iva,
                        co_subtotal_siniva=Entity.co_subtotal_siniva,
                        co_valoriva=Entity.co_valoriva,
                        pe_razonSocial=Entity.pe_razonSocial,
                        
                        
                    };
                }
                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public Boolean guardarDB(cp_retencion_Info info)
        {
            Boolean res = true;
            try
            {
                int secuencia = 1;

                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    cp_retencion Entity = new cp_retencion
                    {

                        IdEmpresa = info.IdEmpresa,
                        IdEmpresa_Ogiro = info.IdEmpresa_Ogiro,
                        IdCbteCble_Ogiro = info.IdCbteCble_Ogiro,
                        IdTipoCbte_Ogiro = info.IdTipoCbte_Ogiro,
                        IdRetencion = info.IdRetencion = get_id(info.IdEmpresa),
                        CodDocumentoTipo = info.CodDocumentoTipo,
                        serie1 = info.serie1,
                        serie2 = info.serie2,
                        NumRetencion = info.NumRetencion,
                        NAutorizacion = info.NAutorizacion,
                        observacion = info.observacion,
                        fecha = Convert.ToDateTime(info.fecha.ToShortDateString()),
                        re_Tiene_RTiva = info.re_Tiene_RTiva,
                        re_Tiene_RFuente = info.re_Tiene_RFuente,
                        re_EstaImpresa = info.re_EstaImpresa,
                        Estado = "A",
                        Fecha_Transac = DateTime.Now,
                        IdUsuario = info.IdUsuario,
                        nom_pc = info.nom_pc,
                        ip = info.ip,
                    };
                    Context.cp_retencion.Add(Entity);

                    foreach (var item in info.detalle)
                    {
                        cp_retencion_det Entity_det = new cp_retencion_det
                        {
                            IdEmpresa = info.IdEmpresa,
                            IdRetencion = info.IdRetencion,
                            Idsecuencia=secuencia,
                            re_tipoRet = item.re_tipoRet,
                            re_Codigo_impuesto=item.re_Codigo_impuesto,
                            re_baseRetencion=(double)item.re_baseRetencion,
                            re_Porcen_retencion= (double)item.re_Porcen_retencion,
                            re_valor_retencion= (double)item.re_valor_retencion,
                            IdCodigo_SRI=item.IdCodigo_SRI,
                            IdUsuario=info.IdUsuario,
                            re_estado="A"
                        };
                        secuencia++;
                        Context.cp_retencion_det.Add(Entity_det);
                    }

                    Context.SaveChanges();
                }
            
                return res;
            }
            catch (Exception )
            {
                throw;

            }
        }
        public bool modificarDB(cp_retencion_Info info)
        {
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    var contact = Context.cp_retencion.FirstOrDefault(minfo => minfo.IdEmpresa == info.IdEmpresa && minfo.IdRetencion == info.IdRetencion);
                    if (contact != null)
                    {
                        contact.observacion = info.observacion;
                        contact.IdUsuarioUltMod = info.IdUsuarioUltMod;
                        contact.Fecha_UltMod = info.Fecha_UltMod;
                        contact.ip = info.ip;
                        Context.SaveChanges();
                       
                    }
                }
                return true;
            }
            catch (Exception )
            {
                throw;

            }
        }
        public Boolean anularDB(cp_retencion_Info info)
        {
            try
            {
                Boolean res = false;
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    var contact = Context.cp_retencion.FirstOrDefault(minfo => minfo.IdEmpresa == info.IdEmpresa && minfo.IdRetencion == info.IdRetencion);
                    if (contact != null)
                    {
                        contact.Estado = "I";
                        contact.observacion = "*ANULADO* " + contact.observacion;
                        contact.Fecha_UltAnu = info.Fecha_UltAnu;
                        contact.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                        Context.SaveChanges();
                        res = true;
                    }
                }
                return res;
            }
            catch (Exception )
            {
                throw;

            }
        }
        public decimal get_id(int IdEmpresa)
        {
            decimal Id;
            try
            {
                using (Entities_cuentas_por_pagar Context = new Entities_cuentas_por_pagar())
                {
                    Id = Context.cp_retencion.Count(C => C.IdEmpresa == IdEmpresa);

                    if (Id == 0)
                        Id = 1;
                    else
                    {
                        decimal select_ = (from C in Context.cp_retencion
                                           where C.IdEmpresa == IdEmpresa
                                           select C.IdRetencion).Max();
                        Id = select_ + 1;
                    }
                    return Id;
                }

            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
